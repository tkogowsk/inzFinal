angular.module('filter', []);
angular.module('filter').controller('FilterController', ['$scope', '$rootScope', '$state', '$log', 'Fields', '$stateParams', 'LocalStorage',
    function ($scope, $rootScope, $state, $log, Fields, $stateParams, LocalStorage) {

        $scope.groupedData = [];
        $scope.activeTabName = null;
        $scope.showFilterSpinner = true;

        function changeSpinner(spinnerIndicator) {
            $scope.showFilterSpinner = spinnerIndicator;
        };

        function init() {
            if (!$rootScope.isAuthenticated()) {
                $state.go('login');
            } else {
                getFields();
                setColumnList();
            }
        }

        function setActiveTab(newName) {
            if ($scope.activeTabName !== newName) {
                $scope.activeTabName = newName;
            }
        }

        function setColumnList() {
            $scope.columnsList = LocalStorage.getColumnList();
        }

        $scope.$on(variantColumnsFetchedEvent + 'Broadcast', function (event, name) {
            setColumnList();
        });

        $scope.getAll = function () {
            $scope.$emit(getAllTranscriptsEvent + "Emit", name);
            $scope.activeFormName = null;
        };


        $scope.filterTabNameClicked = function (name) {
            setActiveTab(name);
        };

        function setFieldValue(currentItem) {
            if (_.isNil(currentItem.value) === true && _.isNil(currentItem.defaultValue) === false) {
                currentItem.value = currentItem.defaultValue;
            }
            if (_.isNil(currentItem.options) === false && currentItem.options.length > 0) {
                currentItem.options = currentItem.options.trim().split(',');
            }
        }

        function getFields() {
            Fields.getFields({
                    sampleFakeId: $stateParams.fakeId
                }, (response) => {
                    let data = _.chain(response.data)
                        .map(function (currentItem) {
                            setFieldValue(currentItem);
                            return currentItem;
                        }).value();

                    let groupedData = _.chain(data)
                        .groupBy('tabName')
                        .toPairs()
                        .map(function (currentItem) {
                            return _.zipObject(['tabName', 'items'], currentItem)
                        })
                        .value();

                    _.forEach(groupedData, function (item) {
                        item.items = _.chain(item.items)
                            .groupBy('filterName')
                            .toPairs()
                            .map(function (currentItem) {
                                return _.zipObject(['filterName', 'items', 'active'], [...currentItem, true])
                            }).value();

                    });
                    $scope.groupedData = groupedData;
                    changeSpinner(false);
                }
            );
        }

        $scope.filter = function (tab) {
            $scope.$emit(filterTabEvent + "Emit", tab);
        };

        $scope.count = function (tab) {
            changeSpinner(true);
            var payload = {};
            var list = [];
            _.forEach(tab.items, function (filters) {
                if (filters.active) {
                    _.forEach(filters.items, function (field) {
                        if (field.value) {
                            list.push({
                                filterName: field.filterName,
                                relation: field.relation,
                                value: field.value,
                                variantColumnId: field.variantColumnId
                            })
                        }
                    })
                }
            });

            payload["counters"] = list;
            payload.tabName = tab.tabName;
            payload.sampleFakeId = parseInt($stateParams.fakeId);
            Fields.count(payload, (response) => {
                for (var i = 0; i < $scope.groupedData.length; ++i) {
                    if ($scope.groupedData[i].tabName === $scope.activeTabName) {
                        $scope.groupedData[i].items.forEach(function (filter) {
                            filter.countValue = null;
                            response.data.forEach(function (elem) {
                                if (elem.filterName === filter.filterName) {
                                    filter.countValue = elem.value
                                }
                            })
                        })
                    }
                }
                changeSpinner(false);
            });
        };

        $scope.saveUserFields = function (tab) {
            changeSpinner(true);
            var payload = [];
            _.forEach(tab.items, function (filters) {
                _.forEach(filters.items, function (field) {
                    payload.push({
                        tabId: field.tabId,
                        fieldId: field.fieldId,
                        filterId: field.filterId,
                        value: field.value || '',
                        sampleFakeId: parseInt($stateParams.fakeId)
                    })
                })
            });

            Fields.save(payload, (response) => {
                changeSpinner(false);
            });
        };

        $scope.getColumnName = function (columnId) {
            if ($scope.columnsList) {
                var elem = _.find($scope.columnsList, function (elem) {
                    return elem.id === columnId;
                });
                return elem.feName;
            }
            return "";
        };

        init();
    }]);
