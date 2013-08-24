#!/usr/bin/env ruby

require "json"

ROOT = File.expand_path("../..", __FILE__)
SPE = /([(0-9)|•|—|–|\-|,|?|!|^|\r|°|“|”|...|\u00a0|«|»|…|\\|\/|!|?|\"|\'|\[|\]|\(|\)|\]|<|>|=|+|%|$|&|#|;|*|:|}|{|`])/

def parseCSV(path)
	Hash[File.open("#{ROOT}/data/#{path}.csv").read.split("\n").map {|ligne| ligne.split("#")}]
end

def exceptions
	@exceptions ||= JSON.parse(File.read("#{ROOT}/data/dict.json"))
end

def conversion
	@conversion ||= parseCSV "conversion"
end

def apion(texte)
	texte = texte.downcase
	texte.gsub(SPE, "").split.map do |mot|
		exceptions[mot] || "".tap do |result|
			conversion.select { |regle| mot =~ /#{regle}/ }.first.tap do |regle, api|
				mot.sub! /#{regle}/, ""
				result << api.to_s
			end until mot.empty?
		end
	end
end

def apion_read(path)
	return apion(File.read(path))
end

