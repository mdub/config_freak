require "config_freak/version"

module ConfigFreak

  extend self

  def expand(input, context = input)
    case input
    when Hash
      expand_hash(input, context)
    when Array
      input.map { |v| expand(v, context) }
    when /\A{{([\w.]+)}}\Z/
      evaluate_expression($1, context)
    when /{{[\w.]+}}/
      input.gsub(/{{([\w.]+)}}/) do
        evaluate_expression($1, context)
      end
    else
      input
    end
  end

  private

  def expand_hash(input, context)
    input.each_with_object({}) do |(k,v), a|
      a[k] = expand(v, context)
    end
  end

  def evaluate_expression(expr, context)
    context.dig(*expr.split("."))
  end

end
