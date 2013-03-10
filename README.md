Caisson
===============

Caisson provide a set of tools to facilitate the integration of Zurb-Foundation to your Rails project.

Install
-------

```
gem install caisson
```

### Rails 3

In your Gemfile:

```ruby
gem 'compass-rails'
gem 'zurb-foundation'
gem 'caisson'
```

In your application.js

```javascript
//= require foundation
//= require caisson
```

In your application.scss
```css
@import "foundation";
```

Orbit Slider
-----

###  Basic examples

```erb
<%= orbit_slider ['apple', 'banana', 'peach'] do |fruit| %>
  <h1>I like <%= fruit %></h1>
<% end %>
```

```erb
<% images = ["img1.jpg", "img2.jpg", "img3.jpg", "img4.jpg"] %>
<%= orbit_slider images, columns_per_slide: 2 do |img| %>
  <img src="<%= img %>" />
<% end %>
```

###  Supported parameters

<table>
  <tr>
    <th>Name</th>
    <th>Default</th>
  </tr>
  <tr>
    <td>advance_speed</td>
    <td>4000</td>
  </tr>
  <tr>
    <td>animation</td>
    <td>horizontal-push</td>
  </tr>
  <tr>
    <td>animation_speed</td>
    <td>400</td>
  </tr>
  <tr>
    <td>bullets</td>
    <td>false</td>
  </tr>
  <tr>
    <td>bullet_thumbs</td>
    <td>false</td>
  </tr>
  <tr>
    <td>bullet_thumbs_location</td>
    <td></td>
  </tr>
  <tr>
    <td>caption_animation</td>
    <td>fade</td>
  </tr>
  <tr>
    <td>caption_animation_speed</td>
    <td>800</td>
  </tr>
  <tr>
    <td>captions</td>
    <td>false</td>
  </tr>
  <tr>
    <td>class</td>
    <td>slider</td>
  </tr>
  <tr>
    <td>columns_per_slide</td>
    <td>1</td>
  </tr>
  <tr>
    <td>directional_nav</td>
    <td>true</td>
  </tr>
  <tr>
    <td>fluid</td>
    <td>16x5</td>
  </tr>
  <tr>
    <td>id</td>
    <td></td>
  </tr>
  <tr>
    <td>pause_on_hover</td>
    <td>true</td>
  </tr>
  <tr>
    <td>reset_timer_on_click</td>
    <td>false</td>
  </tr>
  <tr>
    <td>start_clock_on_mouse_out</td>
    <td>true</td>
  </tr>
  <tr>
    <td>start_clock_on_mouse_out_after</td>
    <td>1000</td>
  </tr>
  <tr>
    <td>timer</td>
    <td>false</td>
  </tr>
</table>

For more details on Orbit, see [Foundation - Orbit](http://foundation.zurb.com/docs/orbit.php).

Copyright
---------

Copyright (c) 2013 De Marque inc. See LICENSE for further details.
