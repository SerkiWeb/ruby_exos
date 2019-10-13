#!/usr/bin/env ruby

require 'csv'

professions = CSV.parse(File.read('appendix/technical-test-professions.csv'), headers: true)
jobs = CSV.parse(File.read('appendix/technical-test-jobs.csv'), headers: true)
tableau_final = Hash.new
professions_V2 = Hash.new

professions.each do |metier|
#	puts "num : " + metier['id'] + " nom : " + metier['name'] + " category : " + metier["category_name"]
	professions_V2[metier['id']] = metier['category_name']
	tableau_final[metier['category_name']] = Hash.new
end

#puts "tableau final :"
#tableau_final.each do |key, value|
#	puts "#{key}"
#	puts "#{value}"
#end

jobs.each do |job|
#	puts "id_profession " + job['profession_id'].to_s + " contract type : " + job['contract_type'].to_s
	id_profession = job['profession_id']
	contract_type = job['contract_type']
	category 	  = professions_V2[id_profession]

	if id_profession.nil?
		next
	end

	if tableau_final[category].has_key?(job['contract_type']) then
		tableau_final[category][contract_type] = tableau_final[category][contract_type] + 1
#		puts " contract_type : " + tableau_final[category][contract_type].to_s
	else
		tableau_final[category][contract_type] = 0
#		puts " contract_type : " + tableau_final[category][contract_type].to_s
	end
end

puts "-------------------------------"
tableau_final.each do |key, value|
	puts key + " categorie : "
	value.each do |key, value|
		puts "contrat #{key} : #{value}"
	end
end



