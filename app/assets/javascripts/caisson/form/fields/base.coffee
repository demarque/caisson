#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
@caissonMod "FormCaisson", ->
  @caissonMod "Field", ->
    class @Base
      #*************************************************************************************
      # CONSTRUCTOR
      #*************************************************************************************
      constructor: (@field) ->
        @build()

      #*************************************************************************************
      # PUBLIC INSTANCE METHODS
      #*************************************************************************************
      build: () ->
        @initPlaceholder()
        @tagField()

        @field.on('validate', (e) => @validate())
        @field.blur (e) => @validate() if @hasErrors()


      closest: (path) -> @field.closest(path)

      data: (key, val) -> @field.data key, val


      hasApproximateName: (names) ->
        return name for name in names when name is @field.attr('name') or @field.attr('name').indexOf("[#{name}]") > 0

        return ''


      hideErrors: ->
        @wrapper().removeClass('errors')
        @wrapper().find('div.error-messages').fadeOut 500, -> $(this).remove()
        $('#form-caisson-flash-' + @id()).fadeOut 500, -> $(this).remove()


      find: (key) -> @field.find key

      hasErrors: -> @wrapper().hasClass('errors')

      id: () -> @field.attr('id')

      input: () -> if @field[0].tagName.toLowerCase() == 'input' then @field else $(@field.find('input'))

      isPlaceholder: () -> !!@field.attr('placeholder')

      isSubmitAuto: () -> @field.data('submit') is 1

      label: () -> @wrapper().find('label')

      labelText: () -> @label().text()

      showErrors: (messages) ->
        @removeErrorMessages()
        @wrapper().addClass('errors')
        @popErrors messages


      validate: () ->
        v = @validator()

        if v.validate() then @hideErrors() else @showErrors v.messages


      validateWithAjax: (url, caller, callback) ->
        $.getJSON url, (data) =>
          if data['state'] is 'error' then @showErrors([data['message']])
          caller[callback]()


      validator: () -> new FormCaisson.Field.Validator(@field.data('validations'), @field.val())

      wrapper: () -> @field.closest('div.field')


      #*************************************************************************************
      # PRIVATE INSTANCE METHODS
      #*************************************************************************************
      initPlaceholder: () ->
        if @isPlaceholder()
          @input().placeholder()
          @input().focus (e) => $(@wrapper().find('.ui-placeholder')).addClass('focus')
          @input().blur (e) => $(@wrapper().find('.ui-placeholder')).removeClass('focus')


      removeErrorMessages: () ->
        @wrapper().find('div.error-messages').remove()
        $('#form-caisson-flash-' + @id()).remove()


      popErrors: (messages) ->
        content = ''
        content += '<span class="text">' + message + '</span>' for message in messages

        flashPop = $('<div class="form-caisson-flash error" id="form-caisson-flash-' + @id() + '">').html(content)

        flashPop.click () -> $(@).fadeOut(700)

        if @hasErrors() then $('body').append(flashPop) else $('body').append(flashPop.hide().fadeIn(700))

        align = ((@field.outerHeight() - flashPop.outerHeight()) / 2)

        flashPop.css
          "left": (@field.offset().left + (@field.outerWidth())) + "px"
          "top": (@field.offset().top + align) + "px"


      tagField: () ->
        @field.data('caisson', 'field')
        @field.attr('data-caisson', 'field')
        @field.attr('id', 'field-caisson-' + Math.floor(Math.random()*10000)) if not @field.attr('id')
