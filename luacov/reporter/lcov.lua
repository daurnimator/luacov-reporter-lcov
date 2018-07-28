-- This is a luacov reporter module that outputs the lcov tracefile format
-- The format is documented in the 'geninfo' manpage

local reporter = require "luacov.reporter"

local md5sumhex
local md5_ok, md5 = pcall(require, "md5")
if md5_ok and md5.sumhexa then -- lmd5 by lhf
	md5sumhex = md5.sumhexa
elseif md5_ok and md5.digest then -- md5 by roberto
	md5sumhex = md5.digest
else
	local luaossl_ok, digest = pcall(require "openssl.digest")
	if luaossl_ok then
		function md5sumhex(str)
			return (digest.new("md5"):final(str)):gsub(".", function(c)
				return string.format("%02x", c:byte())
			end)
		end
	end
end

local LcovReporter = setmetatable({}, reporter.ReporterBase)
LcovReporter.__index = LcovReporter

function LcovReporter:on_new_file(filename)
	self:write("SF:", filename, "\n")
end

function LcovReporter:on_mis_line(filename, lineno, line) -- luacheck: no unused args
	self:write(string.format("DA:%d,%d", lineno, 0))
	if md5sumhex then
		self:write(",", md5sumhex(line))
	end
	self:write("\n")
end

function LcovReporter:on_hit_line(filename, lineno, line, hits) -- luacheck: no unused args
	self:write(string.format("DA:%d,%d", lineno, hits))
	if md5sumhex then
		self:write(",", md5sumhex(line))
	end
	self:write("\n")
end

function LcovReporter:on_end_file(filename, hits, miss) -- luacheck: no unused args
	self:write(string.format("LH:%d\nLF:%d\nend_of_record\n", hits, hits+miss))
end

return {
	LcovReporter = LcovReporter;
	report = function()
		return reporter.report(LcovReporter)
	end;
}
