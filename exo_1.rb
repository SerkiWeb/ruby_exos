#!/usr/bin/env ruby

require 'csv'
class Professions

	attr_accessor :tableau_final
	attr_accessor :professionsById
	attr_accessor :totalOffres 

	def initialize(fileProfessions, fileJobs)
		@fileProfessions, @fileJobs = fileProfessions, fileJobs
		@tableau_final = Hash.new
		@professionsById = Hash.new 
		@totalOffres = 0
	end

	def parseCSVFileProfessions
		professions = CSV.parse(File.read(@fileProfessions), headers: true)

		professions.each do |metier|
			@professionsById[metier['id']] = metier['category_name']
			@tableau_final[metier['category_name']] = Hash.new
			@tableau_final[metier['category_name']]["total"] = 0
		end
	end

	def parseCSVFileJob
		jobs = CSV.parse(File.read(@fileJobs), headers: true)
		jobs.each do |job|
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
			else
				@tableau_final[category][contract_type] = 0
			end 
		end
	end

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
