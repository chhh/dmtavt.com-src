---
# An instance of the Contact widget.
widget: contact

# This file represents a page section.
headless: true

# Order that this section appears on the page.
weight: 1000

title: Contact
subtitle:

content:
  # Automatically link email and phone or display as text?
  autolink: true

  # Email form provider
  # form:
  #   provider: netlify
  #   formspree:
  #     id:
  #   netlify:
  #     # Enable CAPTCHA challenge to reduce spam?
  #     captcha: false

  # Contact details (edit or remove options as required)
  email: dmitry@dmtavt.com
  # phone: 215 459 8827
  address:
    city: Portland
    region: OR
    country: United States
    country_code: US
  coordinates:
    latitude: '45.5152'
    longitude: '-122.6784'
  contact_links:
    - icon: telegram
      icon_pack: fab
      name: Telegram
      link: 'https://t.me/pteech'
    # - icon: video
    #   icon_pack: fas
    #   name: Zoom Me
    #   link: 'https://zoom.com'

design:
  columns: '2'
---
