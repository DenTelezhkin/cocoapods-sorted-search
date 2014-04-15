require 'sorted_search/printers/printer'
require 'cocoapods'

module Pod
  module SortedSearch

    # Printer for pods specification
    #
    class PodPrinter < Printer

      def print(pods)
        pods.each do |pod|
          UI.title("-> #{pod.name} (#{pod.version})".green, '', 1) do
            next unless pod.github_last_activity
            stars = [0x2605].pack("U") + "  " + pod.github_watchers.to_s + " "
            forks = [0x2442].pack("U") + " " + pod.github_forks.to_s + " "
            commit = "Last commit: " + pod.github_last_activity

            UI.puts_indented pod.summary
            UI.puts_indented "pod '#{pod.name}', '~> #{pod.version}'"
            UI.puts_indented stars.yellow + forks.yellow
            UI.puts_indented commit.yellow
          end

        end

        UI.puts
      end
    end

  end
end
