#!/usr/bin/env ruby

require 'test/unit'
require_relative 'exo_1'

class TestProfessions < Test::Unit::TestCase

	def test_parseCSVFileProfessions
		pro = Professions.new('appendix/technical-test-professions.csv', 'appendix/technical-test-jobs.csv')
		pro.parseCSVFileProfessions()
		pro.professionsById.each do |key, value|
			puts "#{key} #{value}"
		end
		assert_equal('Tech', pro.professionsById["17"])
		assert_equal('Retail', pro.professionsById["30"])
		assert_equal('Retail', pro.professionsById["33"])
		assert_not_equal('Tech', pro.professionsById["99"])
		assert_equal(0, pro.totalOffres)
	end

	def parseCSVFileJob
	end
end