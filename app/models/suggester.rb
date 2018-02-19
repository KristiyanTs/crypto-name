# frozen_string_literal: true

class Suggester
  KEY = 'domain'
  TYPES = %w[
    almost_exact
    misspelled
    with_prefix
    with_suffix
    similar
  ].freeze

  def initialize(query)
    @query = query
  end

  def call
    remove_topdomain
    divide_words

<<<<<<< e0de1f543afebbaf11bbb1000dc77fda7f97565d
    {}.tap do |hash|
      TYPES.map do |type|
        send(type).each do |res|
          hash[res] ||= type
        end
      end
    end
=======
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
>>>>>>> Make sure there are no duplicates
  end

  private

  def remove_topdomain
    @query = @query.split('.').first
  end

  def divide_words
    @query = @query.downcase.split(' ')
  end

  def similar
    Suggester::Similar.new(@query).call
  end

  def almost_exact
    [@query.join, @query.join('-')]
  end

  def with_prefix
    domain = @query.join
    (prefix + prefix_suffix).map { |pre| pre + domain }
  end

  def with_suffix
    domain = @query.join
    (suffix + prefix_suffix).map { |after| domain + after }
  end

  def misspelled
    Suggester::Misspelled.new(@query).call
  end

  def prefix
    %w[the my i me we you e top best super ultra all cyber simply free 1st
       meta re metro urban head hit front techno ever vip hot fast fresh best classic
       great quick multi neo mono pico nano micro mega giga
       uni poly eco aero]
  end

  def suffix
    %w[hub point home place site spot web net base city now
       tools source review system book guide talk data vision box focus beat
       zone lab wire news today fun watch story side club]
  end

  def prefix_suffix
    %w[pro media direct access easy info bit up tech on out auto pulse x
       life retro secret io ex]
  end
end
