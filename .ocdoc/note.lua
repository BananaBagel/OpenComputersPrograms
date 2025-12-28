---@meta

--- OpenComputers Note API
---
--- Provides functions to convert music notes to MIDI codes, frequencies, and play notes.
---@class NoteLib
local note = {}

--- Converts a note (string or frequency) to its MIDI code.
---@param n string|number Note name (e.g. "A#4") or frequency
---@return number MIDI code
function note.midi(n) end

--- Converts a note (string or MIDI code) to its frequency in Hz.
---@param n string|number Note name (e.g. "A#4") or MIDI code
---@return number Frequency in Hz
function note.freq(n) end

--- Converts a MIDI code to a note name string.
---@param n number MIDI code
---@return string Note name (e.g. "A#4")
function note.name(n) end

--- Converts note block ticks (0-24) to MIDI code (34-58) and vice versa.
---@param n number Ticks or MIDI code
---@return number MIDI code or ticks
function note.ticks(n) end

--- Plays a note (string or MIDI code) for the specified duration using computer.beep.
---@param tone string|number Note name or MIDI code
---@param duration number Duration in seconds
function note.play(tone, duration) end

return note
