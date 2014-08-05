#= require ./internal.js


###
Loads the parent suite into the tree index.
###
INTERNAL.gotoParentSuite = (callback) ->
  if suite = UIHarness.suite()?.parent
    INTERNAL.index.insertFromLeft(suite, callback)


###
Loads the root suite into the tree index.
###
INTERNAL.gotoRootSuite = (callback) ->
  INTERNAL.index.insertFromLeft(BDD.suite, callback)



###
LOCAL-STORAGE: Gets or sets the UID of the current suite.
###
INTERNAL.currentSuiteUid = (value) -> LocalStorage.prop 'currentSuiteUid', value




Meteor.startup ->
  # Keep the current Suite ID up-to-date.
  Deps.autorun ->
    if currentSuite = UIHarness.suite()
      INTERNAL.currentSuiteUid(currentSuite.uid())

