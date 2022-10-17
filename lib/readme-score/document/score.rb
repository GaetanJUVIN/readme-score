module ReadmeScore
  class Document
    class Score

      SCORE_METRICS = [
        {
          metric: :task_section,
          description: "Task section",
          value: 15
        },
        {
          metric: :description_section,
          description: "Description section",
          value: 20
        },
        {
          metric: :installation_section,
          description: "Installation section",
          value: 20
        },
        {
          metric: :usage_section,
          description: "Usage section",
          value: 25
        },
        {
          metric: :qwasar_reference?,
          description: "Context for the project (Reference to Qwasar)",
          value: 20,
        }
      ]

      attr_accessor :metrics

      def initialize(metrics)
        @metrics = metrics
      end

      def score_breakdown(as_description = false)
        breakdown = {}
        SCORE_METRICS.each { |h|
          metric_option = OpenStruct.new(h)
          metric_name = metric_option.metric_name || metric_option.metric
          metric_score_value = 0
          # points for each occurance
          if metric_option.value_per
            metric_score_value = [metrics.send(metric_option.metric) * metric_option.value_per, metric_option.max].min
          elsif metric_option.if_less_than
            if metrics.send(metric_option.metric) < metric_option.if_less_than
              metric_score_value = metric_option.value
            end
          else
            metric_score_value = metrics.send(metric_option.metric) ? metric_option.value : 0
          end
          if as_description
            breakdown[metric_option.description] = {score: metric_score_value, text: @metrics.text(metric_option.metric), tips: @metrics.tips(metric_option.metric).join("\n")}
          else
            breakdown[metric_name] = metric_score_value
          end
        }
        breakdown
      end
      alias_method :breakdown, :score_breakdown

      def human_breakdown
        score_breakdown(true)
      end

      def total_score
        score = 0
        score_breakdown.each {|metric, points|
          score += points.to_i
        }
        [[score, 100].min, 0].max
      end
      alias_method :to_i, :total_score

      def to_f
        to_i.to_f
      end

      def inspect
        "#<#{self.class} - #{total_score}>"
      end
    end
  end
end
