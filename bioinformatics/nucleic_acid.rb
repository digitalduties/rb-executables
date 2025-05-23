# Add validation to check if valid DNA or RNA

class NucleicAcid
  def initialize(sequence)
    @sequence = sequence
  end

  def self.hamming_distance(seq1, seq2)
    num_chars = if seq1.eql?(seq2) || seq1.size < seq2.size
      seq1.size
    elsif seq2.size < seq1.size
      seq2.size
    end
    range = (0..(num_chars - 1))
    
    count = 0
    seq1[range].chars.each_with_index do | char, index |
      count += 1 if char != seq2[index]
    end

    count
  end
end

class DeoxyriboseNucleicAcid < NucleicAcid
  BASES = ["A", "G", "C", "T"]
  GC_BASES = ["G","C"]
  AT_BASES = ["A", "T"]

  def transcribe
    @sequence.gsub("T", "U")
  end

  def gc_content
    @gc_substring = @sequence.chars.select { |c| GC_BASES.include?(c) }
    @gc_substring.size.to_f / @sequence.size.to_f * 100
  end

  def reverse_complement
    @sequence.chars.map do |char|
      char = if AT_BASES.include?(char)
        AT_BASES.select { |base| base != char }
      elsif GC_BASES.include?(char)
        GC_BASES.select { |base| base != char }
      end
      char
    end.reverse.join("")
  end

  def self.hamming_distance(seq1, seq2)
    super
  end

  def count_nucleotides
    nucleotide_count = Hash.new { |hash, k| hash[k] = 0 }
    @sequence.chars.each do |char|
        nucleotide_count.merge({char => nucleotide_count[char] += 1})
    end
    nucleotide_count
  end
end

class RiboseNucleicAcid < NucleicAcid
  BASES = ["A", "G", "C", "U"]
  GC_BASES = ["G","C"]
  AU_BASES = ["A", "U"]
  CODON_TABLE = {
    "AUG" => "Methionine", "UUU" => "Phenylalanine", "UUC" => "Phenylalanine",
    "UUA" => "Leucine", "UUG" => "Leucine",
    "UAA" => "STOP", "UAG" => "STOP", "UGA" => "STOP"
  }

  def self.reverse_transacribe
    @sequence.gsub("U", "T")
  end

  def hamming_distance(seq1, seq2)
    super
  end

  def translate
    new_sequence = @sequence
    amino_acids = []
    until new_sequence.empty?
      amino_acid = CODON_TABLE[new_sequence[0..2]]
      new_sequence.slice!(0..2)
      amino_acids << amino_acid
    end

    amino_acids.join("-")
  end
end

dna = DeoxyriboseNucleicAcid.new("AGCTATAG")
puts dna.transcribe
puts dna.gc_content
puts DeoxyriboseNucleicAcid.hamming_distance("GAGCCTAAAA", "CATCGT")

dna = DeoxyriboseNucleicAcid.new("AAAACCCGGT")
puts dna.reverse_complement

rna = RiboseNucleicAcid.new("UUGUAAAUGUUUUAGUUUUUC")
puts rna.translate

dna = DeoxyriboseNucleicAcid.new("AGCTTTTCATTCTGACTGCA")
puts dna.count_nucleotides