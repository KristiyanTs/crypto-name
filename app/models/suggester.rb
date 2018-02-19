class Suggester
  KEY = 'domain'.freeze

  def initialize(query, type)
    @query = query
    @type = type
  end

  def call
    suggest
  end

  private

  def suggest
    @suggested ||= generate_domain_names
  end

  def generate_domain_names
    remove_topdomain
    divide_words

    # be sure to have no duplicates
    almost_exact_w = almost_exact.uniq
    misspelled_w   = misspelled.uniq - almost_exact_w
    with_prefix_w  = with_prefix.uniq - almost_exact_w - misspelled_w
    with_suffix_w  = with_suffix.uniq - almost_exact_w - misspelled_w - with_prefix_w
    similar_w      = similar.uniq

    return almost_exact_w if @type == "0"
    return misspelled_w   if @type == "1"
    return with_prefix_w  if @type == "2"
    return with_suffix_w  if @type == "3"
    return similar_w      if @type == "4"
  end

  def remove_topdomain
    @query = @query.split('.').first
  end

  def divide_words
    @query = @query.downcase.split(' ')
  end

  def to_word_groups
    generated = @query.dup
    counter = 0
    generated.each do |w|
      generated[counter] = [w]
      ['equivalent', 'synonym', 'verb-form', 'verb-stem'].each do |category|
        list = Wordnik.word.get_related(w, type: category, use_canonical: true)
        generated[counter] += list.first['words'].select { |w| w.size < 10}.map{ |w| w.downcase.gsub(' ', '')} if list.any?
      end
      counter+=1
    end
    generated
  end

  def mix_groups word_groups
    answer = []
    if word_groups.size > 1
      answer = word_groups[0].product(word_groups[1]) if word_groups.size == 2
      answer = word_groups[0].product(word_groups[1], word_groups[2]) if word_groups.size == 3
      answer = word_groups[0].product(word_groups[1], word_groups[3], word_groups[4]) if word_groups.size == 4
      answer = answer.map { |gr| gr.permutation.to_a.map{ |inner_gr| inner_gr.join }}.flatten
    end
    answer
  end

  def similar
    word_groups = to_word_groups
    mix_groups word_groups
  end

  def almost_exact
    [@query.join(), @query.join('-')]
  end

  def with_prefix
    domain = @query.join()
    (prefix+prefix_suffix).map{|pre| pre + domain}
  end

  def with_suffix
    domain = @query.join()
    (suffix+prefix_suffix).map{|after| domain + after}
  end

  def misspelled
    case @query.size
    when 1
      return misspell @query[0]
    when 2
      return (misspell @query[0]).product([@query[1]]).map { |gr| gr.join } + 
             [@query[0]].product(misspell @query[1]).map { |gr| gr.join }  + 
             (misspell @query[0]).product(misspell @query[1]).map { |gr| gr.join }
    when 3
      return (misspell @query[0]).product([@query[1] + @query[2]]).map { |gr| gr.join } +                                                #misspell #1
            ([@query[0]]).product((misspell @query[1]).product([@query[2]]).map { |gr| gr.join }).map { |gr| gr.join } +                 #misspell #2 
            ([@query[0]]).product([@query[1]].product(misspell @query[2]).map { |gr| gr.join }).map { |gr| gr.join } +                   #misspell #3 
            (misspell @query[0]).product((misspell @query[1]).product([@query[2]]).map { |gr| gr.join }).map { |gr| gr.join } +          #misspell #1&#2 
            (misspell @query[0]).product([@query[1]].product(misspell @query[2]).map { |gr| gr.join }).map { |gr| gr.join } +            #misspell #1&#3 
            [@query[0]].product((misspell @query[1]).product(misspell @query[2]).map { |gr| gr.join }).map { |gr| gr.join } +            #misspell #2&#3 
            (misspell @query[0]).product((misspell @query[1]).product(misspell @query[2]).map { |gr| gr.join }).map { |gr| gr.join }     #misspell #1&#2&#3 
    else
      return misspell @query.join
    end
  end

  def misspell word
    generated = []
    generated << word.gsub('oo', 'u')
    generated << word.gsub('qu', 'q')
    generated << word.gsub('ex', 'x')
    generated << word.gsub('ics', 'ix')
    generated << word.gsub('to', '2')
    generated << word.gsub('too', '2')
    generated << word.gsub('tion', 'shun')
    generated << word.gsub('er', 'r')
    generated << word.gsub('ss', 's')
    generated << word.gsub('rr', 'r')
    generated << word.gsub('ll', 'l')
    generated << word.gsub('ake', 'eik')
    generated << word.gsub('ake', 'eic')
    generated << word.gsub('y', 'i')
    generated << word.gsub('i', 'y')
    generated << word.gsub('s', 'z')
    generated << word.gsub('c', 'k')
    generated << word.gsub('ape', 'eip')
    generated << word.gsub('ine', 'ain')
    generated << word.gsub('the', 'd')
    generated << word.gsub('su', 'shu')
    generated << word.gsub('aby', 'eiby')
    generated << word.gsub('ide', 'aid')
    generated << word.gsub('ide', 'ait')
    generated << word.gsub('ight', 'it')
    generated << word.gsub('th', 'd')
    generated << word.gsub('th', 't')
    generated << word.gsub('e', '')
    generated << word.gsub('ck', 'k')
    generated << word.gsub('w', 'u')
    generated << word.gsub('ue', 'u')
    generated << word.gsub('ou', 'au')
    generated << word.gsub('our', 'ur')
    generated << word.gsub('er', 'r')
    generated << word.gsub('or', 'r')

    generated.uniq
  end

  def prefix
    ['the', 'my', 'i', 'me', 'we', 'you', 'e', 'top', 'best', 'super', 'ultra', 'all', 'cyber', 'simply', 'free', '1st',
    'meta', 're', 'metro', 'urban', 'head', 'hit', 'front', 'techno', 'ever', 'vip', 'hot', 'fast', 'fresh', 'best', 'classic',
    'great', 'quick', 'multi', 'neo', 'mono', 'pico', 'nano', 'micro', 'mega', 'giga',
    'uni', 'poly', 'eco', 'aero']
  end

  def suffix
    ['hub', 'point', 'home', 'place', 'site', 'spot', 'web', 'net', 'base', 'city', 'now',
    'tools', 'source', 'review', 'system', 'book', 'guide', 'talk', 'data', 'vision', 'box', 'focus', 'beat', 
    'zone', 'lab', 'wire', 'news', 'today', 'fun', 'watch', 'story', 'side', 'club']
  end

  def prefix_suffix
    ['pro', 'media', 'direct', 'access', 'easy', 'info', 'bit', 'up', 'tech', 'on', 'out', 'auto', 'pulse', 'x', 
    'life', 'retro', 'secret', 'io', 'ex']
  end
end