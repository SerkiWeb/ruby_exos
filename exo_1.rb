#!/usr/bin/env ruby

require 'csv'
class Professions 

	def initialize(fileProfessions, fileJobs)
		@fileProfessions, @fileJobs = fileProfessions, fileJobs
		@tableau_final = Hash.new
		@professionsById = Hash.new 
		@totalOffres = 0
	end

	def parseCSVFileProfessions
		professions = CSV.parse(File.read(@fileProfessions), headers: true)

		professions.each do |metier|
			#puts "num : " + metier['id'] + " nom : " + metier['name'] + " category : " + metier["category_name"]
			@professionsById[metier['id']] = metier['category_name']
			@tableau_final[metier['category_name']] = Hash.new
			@tableau_final[metier['category_name']]["total"] = 0
		end
	end
	protected :parseCSVFileProfessions

	def parseCSVFileJob
		jobs = CSV.parse(File.read(@fileJobs), headers: true)
		jobs.each do |job|
		#	puts "id_profession " + job['profession_id'].to_s + " contract type : " + job['contract_type'].to_s
			id_profession = job['profession_id']
			contract_type = job['contract_type']
			category 	  = @professionsById[id_profession]

			if id_profession.nil?
				next
			end

			@totalOffres = @totalOffres + 1
			if @tableau_final[category].has_key?(job['contract_type']) then
				@tableau_final[category][contract_type] = @tableau_final[category][contract_type] + 1
				@tableau_final[category]["total"] = @tableau_final[category]["total"] + 1 
				#puts " contract_type : " + @tableau_final[category][contract_type].to_s
			else
				@tableau_final[category][contract_type] = 0
				#puts " contract_type : " + @tableau_final[category][contract_type].to_s
			end 
		end
	end
	protected :parseCSVFileJob

	def sortJobsBycategories
		parseCSVFileProfessions()
		parseCSVFileJob()
	end

	def printTableauFinal
		puts "-------------------------------"
		puts "Total : " + @totalOffres.to_s
		@tableau_final.each do |key, value|
			puts "Categorie : " + key.to_s
			puts "Total  : " + @tableau_final[key]["total"].to_s
			value.each do |key, value|
				if key == "total"
					next
				end
				puts "contrat #{key} : #{value}"
			end
		end
	end
end

pro = Professions.new('appendix/technical-test-professions.csv', 'appendix/technical-test-jobs.csv') 
pro.sortJobsBycategories()
pro.printTableauFinal()
