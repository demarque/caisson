#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
@caissonMod "FormCaisson", ->
  @caissonMod "Field", ->
    class @Checkbox extends FormCaisson.Field.Base
      #*************************************************************************************
      # CONSTRUCTOR
      #*************************************************************************************
      constructor: (@field) ->
        if @isSubmitAuto() then @input().change (event) => @closest('form').submit()

        super @field
