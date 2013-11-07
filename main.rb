require_relative 'report'

report = Report.new(:transaction_data => File.read('test/TRANSACTIONS.csv'), :conversion_table => File.read('test/conversion_table.xml'))
puts report.total_for('DM1182')
