###
Handles the SELECT options on a Spec index-tree item.
###
class PKG.SpecTypeSelect extends PKG.SpecTypeBase
  ready: ->
    # Sync the <select> with the current property value.
    @autorun =>
      @specCtrl.el('select').val(@prop())


  onLoaded: -> @prop(@localStorage())


  ###
  Gets or sets the local storage value stored on the spec
  for the <select> UI element.
  ###
  localStorage: (value) -> @spec.localStorage 'select-value', value


  ###
  The <option> values used by the template.
  ###
  options: ->
    options = Util.asValue(@meta.options)
    result = []
    if Object.isArray(options)
      for item in options
        if Object.isObject(item)
          { label, value } = item
          value = label if not value? and label?
        else
          label = item
          value = item
        result.push { label:label, value:value }

    if Object.isObject(options)
      for key, value of options
        result.push { label:key, value:value }

    for item in result
      # Escape [null] and [undefined] values.
      value = item.value
      value = 'null' if value is null
      value = 'undefined' if value is undefined
      item.value = value

      # Format the label.
      item.label = @formatLabel(item.label)

    # Finish up.
    result



  ###
  Invoked when the <select> changes.
  ###
  onChange: (e) ->
    # Store the new value.
    value = @formatValue(e.target.value)
    @localStorage(value)

    # Update the API.
    @prop(value)

    # Pass execution to the [Spec].
    @specCtrl.run()
