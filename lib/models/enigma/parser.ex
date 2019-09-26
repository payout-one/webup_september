defprotocol Enigma.Parser do
  def load(struct_type, enigma)
  def get_country(struct_type)
end
