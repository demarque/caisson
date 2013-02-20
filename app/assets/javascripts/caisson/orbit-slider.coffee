#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
class @OrbitSlider
  constructor: (@holder) ->
    @holder.orbit @buildAttributes()


  buildAttributes: () ->
    {
      advanceSpeed:               @getAttr('advance-speed'),
      animation:                  @getAttr('animation'),
      animationSpeed:             @getAttr('animation-speed'),
      bulletThumbLocation:        @getAttr('bullet-thumb-location'),
      bulletThumbs:               @getBoolAttr('bullet-thumbs'),
      bullets:                    @getBoolAttr('bullets'),
      captionAnimation:           @getAttr('caption-animation'),
      captionAnimationSpeed:      @getAttr('caption-animation-speed'),
      captions:                   @getBoolAttr('captions'),
      directionalNav:             @getBoolAttr('directional-nav'),
      fluid:                      @getAttr('fluid'),
      pauseOnHover:               @getBoolAttr('pause-on-hover'),
      resetTimerOnClick:          @getBoolAttr('reset-timer-on-click'),
      startClockOnMouseOut:       @getBoolAttr('start-clock-on-mouse-out'),
      startClockOnMouseOutAfter:  @getAttr('start-clock-on-mouse-out-after'),
      timer:                      @getBoolAttr('timer')
    }

  getAttr: (name) -> @holder.data(name),

  getBoolAttr: (name) -> if String(@holder.data(name)) is '1' then true else false



