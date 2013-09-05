#!/usr/bin/env ruby

module Apion

	require "json"
	require "timeout"

	ROOT = File.expand_path("../..", __FILE__)
	eval(File.read("#{ROOT}/lib/special_chars.rb"))

	def Apion.parseCSV(path)
		Hash[File.open("#{ROOT}/data/#{path}.csv").read.split("\n").map {|ligne| ligne.split("#")}]
	end

	def Apion.exceptions
		@exceptions ||= JSON.parse(File.read("#{ROOT}/data/dict.json"))
	end

	def Apion.conversion
		@conversion ||= parseCSV "conversion"
	end

	def Apion.apion(texte)
		texte = texte.downcase
		texte.gsub(SPE, "").split.map do |mot|
			exceptions[mot] || "".tap do |result|
				Timeout::timeout(1) do
					conversion.select { |regle| mot =~ /#{regle}/ }.first.tap do |regle, api|
						mot.sub! /#{regle}/, ""
						result << api.to_s
					end until mot.empty?
				end
			end
		end
	rescue Timeout::Error
		return []
	end

end

