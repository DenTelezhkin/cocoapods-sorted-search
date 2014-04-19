require 'sorted_search/printers/printer'
require 'cocoapods'

module SortedSearch

  # Printer for pods specification
  #
  class PodPrinter < Printer

    def print(pods)
      pods.each do |pod|
        Pod::UI.title("-> #{pod.name} (#{pod.version})".green, '', 1) do
          next unless pod.github_last_activity
          stars = [0x2605].pack('U') + '  ' + pod.github_watchers.to_s + ' '
          forks = [0x2442].pack('U') + ' ' + pod.github_forks.to_s + ' '
          commit = 'Last commit: ' + pod.github_last_activity

          Pod::UI.puts_indented pod.summary
          Pod::UI.puts_indented "pod '#{pod.name}', '~> #{pod.version}'"
          Pod::UI.puts_indented stars.yellow + forks.yellow
          Pod::UI.puts_indented commit.yellow
        end

      end

      Pod::UI.puts
    end
  end

end
