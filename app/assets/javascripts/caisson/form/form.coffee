#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
@caissonMod "FormCaisson", ->
  class @Form
    #*************************************************************************************
    # CONSTRUCTOR
    #*************************************************************************************
    constructor: (@form) ->
      @fields = []

      @initFormId()
      @initEvents()
      @initFields()


    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    field: (id) -> return f for f in @fields when f.id() is id

    hasErrors: () -> @form.find('div.field.errors').length > 0

    hasField: (id) -> if @field(id) then true else false

    hideErrors: () -> field.hideErrors() for field in @fields

    id: () -> @form.attr('id')

    send: (callback) ->
      if @validate()
        callback = {} if not callback
        callback['loading'](true) if callback['loading']

        $.ajax(
          type: @form.attr('method')
          url: @form.attr("action") + '.json'
          dataType: "json"
          data: @form.serialize()
          complete: (data) -> callback['loading'](false) if callback['loading']
          error: (xhr, ajax_error) =>
            switch xhr.status
              when 400 then @setFieldErrors $.parseJSON(xhr.responseText)
              when 401 then #alert '401'
              else @showAjaxError xhr.responseText, ajax_error
          statusCode: callback
        )


    validate: () ->
      field.validate() for field in @fields

      if @hasErrors()
        @form.find('div.field.errors:first input').focus()
        return false
      else
        return true


    #*************************************************************************************
    # PRIVATE INSTANCE METHODS
    #*************************************************************************************
    initEvents: () ->
      @form.on('validate', (e) => @validate())
      @form.on('send', (e) => @send())

      @form.submit (e) =>
        if @validate()
          field.input().trigger 'before-submit-form' for field in @fields

          $(e.target).find('input[type=submit]').attr 'disabled', 'disabled'
          $(e.target).find('button').attr 'disabled', 'disabled'

          return true
        else
          return false


    initField: (path, fieldClass) -> @form.find(path).each (i, elem) => @fields.push new fieldClass $(elem)


    initFields: ->
      @initField 'input.checkbox',      FormCaisson.Field.Checkbox
      @initField 'select',              FormCaisson.Field.SelectField
      #@_initField 'div.switch-field',    FormCaisson.Field.SwitchField
      @initField 'input.text-field',    FormCaisson.Field.TextField
      #@_initField 'input.percent-field', FormCaisson.Field.PercentField
      #@_initField 'input.money-field',   FormCaisson.Field.MoneyField
      #@_initField 'div.time-field',      FormCaisson.Field.TimeField


    initFormId: ->
      @form.data('caisson', 'form')
      @form.attr('data-caisson', 'form')
      @form.attr('id', 'form-caisson-' + Math.floor(Math.random()*10000)) if not @form.attr('id')


    setFieldErrors: (errors) ->
      names = (k for k,v of errors)

      for field in @fields
        errorKey = field.hasApproximateName names

        if errorKey
          field.showErrors $.flatten(errors[errorKey])
        else if field.hasErrors()
          field.hideErrors()

      return errors


    showAjaxError: (message, ajax_error) ->
      left = ($('body').width() - 700) / 2

      pop = $('<div id="ajax-error" style="display:none;margin-left:' + left + 'px"><h1>AJAX : ' + ajax_error + '</h1>' + message + '</div>')
      pop.dblclick (e) -> $(e.target).closest('div#ajax-error').remove()

      $('body').before pop
      pop.fadeIn(500)
