#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
@caissonMod "FormCaisson", ->
  @caissonMod "Field", ->
    class @Validator
      #*************************************************************************************
      # CONSTRUCTOR
      #*************************************************************************************
      constructor: (specs, @value) ->
        @specs = if specs then specs.split(' ') else []
        @messages = []


      #*************************************************************************************
      # PUBLIC INSTANCE METHODS
      #*************************************************************************************
      checkSpec: (spec) ->
        stripped_spec = spec.split('-')[0]

        if stripped_spec is 'blank'
          @isBlank()
        else if @notBlank()
          switch stripped_spec
            when 'confirm' then @isConfirmed spec
            when 'creditcard' then @isCreditCard spec
            when 'creditcardname' then @isCreditCardName()
            when 'creditcardexpiration' then @isCreditCardExpiration()
            when 'email' then @isEmail()
            when 'length' then @isLengthEql spec
            when 'max' then @isMax spec
            when 'min' then @isMin spec
            when 'numeric' then @isNumeric()
            when 'within' then @isWithin spec
            else


      getCreditCardType: (rawCCNumber) ->
        ccNumber = rawCCNumber.replace(/(\s|-)/g, '')

        if /^4[0-9]{12}(?:[0-9]{3})?$/.test(ccNumber)
          'visa'
        else if /^5[1-5][0-9]{14}$/.test(ccNumber)
          'mastercard'
        else if /^3[47][0-9]{13}$/.test(ccNumber)
          'amex'
        else
          ''


      isValid: () -> @messages.length is 0

      validate: () ->
        @checkSpec spec for spec in @specs if @specs

        return @isValid()


      #*************************************************************************************
      # PRIVATE INSTANCE METHODS
      #*************************************************************************************
      isBlank: () -> if @value is "" then @messages.push 'Le champ ne peut être vide.'

      isConfirmed: (spec) ->
        [tag, idOtherField] = spec.split('-')

        if @value isnt $('#' + idOtherField).val() then @messages.push 'La confirmation est erronée'


      isCreditCard: (spec) ->
        types = spec.replace('creditcard-', '').split('-')
        currentType = @getCreditCardType @value
        if $.inArray(currentType, types) is -1 then @messages.push "Le numéro de carte de crédit est invalide."


      isCreditCardName: () -> if not /^\S+ \S+/.test(@value) then @messages.push "Entrez le nom complet figurant sur votre carte."

      isCreditCardExpiration: () ->
        value = @value.replace('/', '').replace('-', '').replace(' ', '')

        value = value.slice(0,2) + '20' + value.slice(2,4) if value.length is 4

        if value.length is 6 and /^[0-9]*$/.test value
          expiration = new Date(value.slice(2,6), Number(value.slice(0,2)) - 1, 31)

          if expiration < new Date() then @messages.push "Votre carte de crédit est expirée."
        else
          @messages.push "La date d'expiration est doit avoir un format MM/AA."


      isEmail: () -> if not /^[a-zA-Z0-9.\$#%+-\/=?_]+@([a-zA-Z0-9.\-]+\.)+[a-zA-Z0-9.\-]{2,}$/.test(@value) then @messages.push 'Le courriel est invalide.'

      isLengthEql: (spec) ->
        [tag, length] = spec.split('-')
        if @value.length != Number(length) then @messages.push "Le champ doit contenir #{length} caractères."

      isMax: (spec) ->
        [tag, max] = spec.split('-')
        if @value.length > Number(max) then @messages.push "Le champ doit contenir moins de #{max} caractères."


      isMin: (spec) ->
        [tag, min] = spec.split('-')
        if @value.length < Number(min) then @messages.push "Le champ doit contenir plus de #{min} caractères."


      isNumeric: -> if not /^$|^([\-]?[0-9]*)?([\.,][0-9]*)?$/.test(@value) then @messages.push 'Le champ doit être numérique.'

      isWithin: (spec) ->
        [tag, min, max] = spec.split('-')

        @isMin "min-#{min}"
        @isMax "max-#{max}"


      notBlank: () -> @value isnt ""
