# frozen_string_literal: true

module TLDTypes
  POPULAR = ['.com', '.org', '.edu', '.gov', '.uk', '.net', '.info', '.biz', '.me', '.life'].freeze
  CHEAP = ['.site', '.fun', '.info', '.online', '.life', '.live', '.band', '.agency', '.bike', '.business', '.city', '.cloud', '.coffee', '.company', '.cool',
           '.credit', '.dance', '.email', '.express', '.fyi', '.gold', '.group', '.institute',
           '.international', '.ltd', '.network', '.ninja', '.photography',
           '.place', '.run'].freeze

  PROFESSIONAL = ['.art', '.academy', '.accountant', '.agency', '.biz', '.careers', '.company', '.deals', '.doctor', '.education', '.expert', '.legal', '.ltd', '.studio', '.study', '.work'].freeze

  NEW = ['.academy', '.accountant', '.accountants', '.actor', '.adult', '.agency', '.airforce', '.amsterdam', '.apartments', '.archi',
         '.army', '.art', '.associates', '.attorney', '.auction', '.auto', '.band', '.bar', '.barcelona', '.bargains', '.bayern', '.beer',
         '.berlin', '.best', '.bet', '.bid', '.bike', '.bingo', '.bio', '.black', '.blog', '.blue', '.boston', '.boutique', '.build',
         '.builders', '.business', '.buzz', '.cab', '.cafe', '.camera', '.camp', '.capital', '.car', '.cards', '.care', '.careers',
         '.cars', '.casa', '.cash', '.casino', '.catering', '.center', '.ceo', '.chat', '.cheap', '.church', '.city', '.claims', '.cleaning',
         '.clinic', '.clothing', '.cloud', '.club', '.coach', '.codes', '.coffee', '.college', '.community', '.company', '.computer',
         '.condos', '.construction', '.consulting', '.contractors', '.cooking', '.cool', '.country', '.coupons', '.courses', '.credit',
         '.creditcard', '.cricket', '.cruises', '.cymru', '.dance', '.date', '.dating', '.deals', '.degree', '.delivery', '.democrat',
         '.dental', '.dentist', '.desi', '.design', '.diamonds', '.digital', '.direct', '.directory', '.discount', '.doctor', '.dog',
         '.domains', '.download', '.earth', '.education', '.email', '.energy', '.engineer', '.engineering', '.enterprises', '.equipment',
         '.estate', '.events', '.exchange', '.expert', '.exposed', '.express', '.fail', '.faith', '.family', '.fans', '.farm', '.fashion',
         '.film', '.finance', '.financial', '.fish', '.fishing', '.fit', '.fitness', '.flights', '.florist', '.football', '.forsale', '.foundation',
         '.fun', '.fund', '.furniture', '.futbol', '.fyi', '.gallery', '.games', '.garden', '.gifts', '.gives', '.glass', '.global', '.gmbh', '.gold',
         '.golf', '.graphics', '.gratis', '.green', '.gripe', '.group', '.guide', '.guru', '.haus', '.health', '.healthcare', '.hockey', '.holdings',
         '.holiday', '.horse', '.hospital', '.host', '.house', '.immo', '.immobilien', '.industries', '.ink', '.institute', '.insure', '.international',
         '.investments', '.irish', '.ist', '.istanbul', '.jetzt', '.jewelry', '.kaufen', '.kim', '.kitchen', '.kiwi', '.land', '.lawyer', '.lease',
         '.legal', '.lgbt', '.life', '.lighting', '.limited', '.limo', '.live', '.loan', '.loans', '.london', '.love', '.ltd', '.ltda', '.luxury',
         '.maison', '.management', '.market', '.marketing', '.mba', '.media', '.melbourne', '.memorial', '.men', '.menu', '.miami', '.moda',
         '.moe', '.money', '.mortgage', '.movie', '.nagoya', '.navy', '.network', '.news', '.ninja', '.nrw', '.nyc', '.okinawa', '.one', '.onl',
         '.online', '.paris', '.partners', '.parts', '.party', '.pet', '.photography', '.photos', '.pictures', '.pink', '.pizza', '.place',
         '.plumbing', '.plus', '.poker', '.porn', '.press', '.pro', '.productions', '.promo', '.properties', '.protection', '.pub', '.pw',
         '.qpon', '.quebec', '.racing', '.recipes', '.red', '.rehab', '.reise', '.reisen', '.rent', '.rentals', '.repair', '.report', '.republican',
         '.rest', '.restaurant', '.review', '.reviews', '.rich', '.rip', '.rocks', '.rodeo', '.run', '.ryukyu', '.sale', '.salon', '.sarl', '.school',
         '.schule', '.science', '.security', '.services', '.sex', '.shiksha', '.shoes', '.shop', '.shopping', '.show', '.singles', '.site', '.ski',
         '.soccer', '.social', '.software', '.solar', '.solutions', '.space', '.storage', '.store', '.stream', '.studio', '.study', '.style',
         '.supplies', '.supply', '.support', '.surf', '.surgery', '.sydney', '.systems', '.tax', '.taxi', '.team', '.tech', '.technology',
         '.tennis', '.theater', '.theatre', '.tienda', '.tips', '.tires', '.today', '.tokyo', '.tools', '.tours', '.town', '.toys', '.trade',
         '.training', '.tube', '.university', '.uno', '.vacations', '.vegas', '.ventures', '.vet', '.viajes', '.video', '.villas', '.vin', '.vip',
         '.vision', '.vodka', '.vote', '.voting', '.voto', '.voyage', '.wales', '.watch', '.webcam', '.website', '.wedding', '.wiki', '.win',
         '.wine', '.work', '.works', '.world', '.wtf', '.xyz', '.yoga', '.yokohama', '.zone'].freeze

  TYPES = {
    0 => POPULAR,
    1 => CHEAP,
    2 => PROFESSIONAL,
    3 => NEW
  }.freeze

  class << self
    def [](category)
      TYPES[category]
    end
  end
end
