require 'sorted_search/printers/printer'
require 'cocoapods'

module SortedSearch

  # Printer for pods specification
  #
  class GitHubPrinter < Printer

    def print(pods)

      pods.each do |array|
        pod = array[0]
        mash = array[1]

        Pod::UI.title("-> #{pod.name} (#{pod.version})".green, '', 1) do
          stars = [0x2605].pack('U') + '  '
          forks = [0x2442].pack('U') + ' '
          commit = 'Last commit: '

          if mash.name
            stars  += mash.stargazers_count.to_s + ' '
            forks  += mash.forks.to_s + ' '
            commit += distance_from_now_in_words(mash.pushed_at)
          else
            stars  += "Unknown "
            forks  += "Unknown "
            commit += "Unknown "
          end

          Pod::UI.puts_indented pod.summary
          Pod::UI.puts_indented "pod '#{pod.name}', '~> #{pod.version}'"
          Pod::UI.puts_indented stars.yellow + forks.yellow
          Pod::UI.puts_indented commit.yellow
        end
      end

      Pod::UI.puts
    end

    def distance_from_now_in_words(from_time)
      return nil unless from_time
      from_time = Time.parse(from_time) unless from_time.is_a?(Time)
      to_time = Time.now
      distance_in_days = (((to_time - from_time).abs) / 60 / 60 / 24).round

      case distance_in_days
        when 0..7
          "less than a week ago"
        when 8..29
          "#{distance_in_days} days ago"
        when 30..45
          "1 month ago"
        when 46..365
          "#{(distance_in_days.to_f / 30).round} months ago"
        else
          "more than a year ago"
      end
    end

  end

end
