module ReadmeScore
  class Document
    class Metrics
      EQUATION_METRICS = [
        :cumulative_code_block_length
      ]
      def initialize(noko_or_html)
        @noko = Util.to_noko(noko_or_html)
        @noko
      end

      def cumulative_code_block_length
        all_code_blocks.inner_html.length
      end

      def number_of_links
        all_links.length
      end

      def number_of_code_blocks
        all_code_blocks.length
      end

      def number_of_paragraphs
        all_paragraphs.length
      end

      def qwasar_reference?
        all_links.any? do |a|
          a['href'].downcase.index('https://qwasar.io')
        end
      end

      def is_it_a_paragraph?(node)
        node.name == 'p'
      end

      def has_it_been_filled?(node)
        node.text.size > 30 and node.text.index('TODO -') == nil
      end

      def eval_section(named)
        section = all_h2_title.select { |aht| aht.text == named }.first

        if section
          next_block = section.next_element
          if next_block == nil
            return false
          elsif has_it_been_filled?(next_block) == false
            return false
          end
          true
        else
          false
        end
      end

      def task_section
        eval_section('Task')
      end

      def description_section
        eval_section('Description')
      end

      def installation_section
        eval_section('Installation')
      end

      def usage_section
        eval_section('Usage')
      end

      def number_of_non_code_sections
        (all_paragraphs + all_lists).length
      end

      def code_block_to_paragraph_ratio
        if number_of_paragraphs.to_f == 0.0
          return 0
        end
        number_of_code_blocks.to_f / number_of_paragraphs.to_f
      end

      def number_of_internal_links
        all_links.select {|a|
          internal_link?(a)
        }.count
      end

      def number_of_external_links
        all_links.reject {|a|
          internal_link?(a)
        }.count
      end

      def has_lists?
        all_lists.length > 0
      end

      def has_images?
        number_of_images > 0
      end

      def number_of_images
        all_images.count
      end

      def has_gifs?
        number_of_gifs > 0
      end

      def number_of_gifs
        all_gifs.length
      end

      def has_tables?
        !all_tables.empty?
      end

      def inspect
        "#<#{self.class}>"
      end

      private
        def all_links
          @noko.search('a')
        end

        def all_code_blocks
          @noko.search('pre')
        end

        def all_paragraphs
          @noko.search('p')
        end

        def all_h2_title
          @noko.search('h2')
        end


        def all_lists
          @noko.search('ol') + @noko.search('ul')
        end

        def all_images
          @noko.search('img')
        end

        def all_gifs
          all_images.select {|a|
            source_attributes = ['src', 'data-canonical-src']
            source_attributes.map {|_attr|
              a[_attr] && a[_attr].downcase.include?(".gif")
            }.any?
          }
        end

        def all_tables
          @noko.search('table')
        end

        def internal_link?(a)
          external_prefixes = %w{http}
          href = a['href'].downcase

          return true if href.include?("://github") || href.include?("github.io")

          external_prefixes.select {|prefix|
            href.start_with?(prefix)
          }.any?
        end

    end
  end
end
