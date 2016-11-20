# This class is used for registering types of events while parsing an XML document.
# http://www.rubydoc.info/github/sparklemotion/nokogiri/Nokogiri/XML/SAX/Document
class TimsDocument < Nokogiri::XML::SAX::Document
  attr_reader :points

  def initialize
    @points = []
  end

  private

  def start_element(name, attrs = [])
    if name == 'DisplayPoint'
      @displaypoint = true
    end

    if name == 'coordinatesLL'
      @coordinatesll = true
    end
  end

  def characters(str)
    if @displaypoint && @coordinatesll
      @points << str
    end
  end

  def end_element(name)
    if name == 'DisplayPoint'
      @displaypoint = false
    end

    if name == 'coordinatesLL'
      @coordinatesll = false
    end
  end
end
