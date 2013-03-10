#*************************************************************************************
# TOCOMMENT
# TODO : Add keyboard shortcuts
#*************************************************************************************
@caissonMod "FormCaisson", ->
  @caissonMod "Field", ->
    class @SelectField extends FormCaisson.Field.Base
      #*************************************************************************************
      # CONSTRUCTOR
      #*************************************************************************************
      constructor: (@field) ->
        if @isSubmitAuto() then $(@field).change (event) => @closest('form').submit()

        super @field
