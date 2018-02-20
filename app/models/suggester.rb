# frozen_string_literal: true

class Suggester
  KEY = 'domain'
  TYPES = %w[
    almost_exact
    misspelled
    with_prefix
    with_suffix
  ].freeze

  def initialize(query)
    @query = query
  end

  def call
    remove_topdomain
    divide_words

    {}.tap do |hash|
      TYPES.map do |type|
        hash[type] = send(type).uniq
      end
    end
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
