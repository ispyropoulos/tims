require 'test_helper'

class TimsDocumentTest < ActiveSupport::TestCase
  subject { TimsDocument.new }
  let(:xml_contents) do
    <<-XML
<?xml version="1.0" encoding="ISO-8859-1"?>
<Root xmlns="http://www.tfl.gov.uk/tims/1.0">
 <Disruptions>
  <Disruption id='143306'>
   <CauseArea>
    <DisplayPoint>
     <Point>
      <coordinatesEN>541443,189139</coordinatesEN>
      <coordinatesLL>040108,51.583302</coordinatesLL>
     </Point>
    </DisplayPoint>
   </CauseArea>
  </Disruption>
 <Disruption id='143081'>
   <CauseArea>
    <DisplayPoint>
     <Point>
      <coordinatesEN>530974,180080</coordinatesEN>
      <coordinatesLL>-.114291,51.504414</coordinatesLL>
     </Point>
    </DisplayPoint>
   </CauseArea>
  </Disruption>
 <Disruptions>
    XML
  end

  describe "#points" do
    describe "when the instance is used as an event listener to Nogokiri's SAX parser" do
      before do
        Nokogiri::XML::SAX::Parser.new(subject).parse(xml_contents)
      end

      it "should return an array of lat lng coordinates" do
        subject.points.must_equal %w(040108,51.583302 -.114291,51.504414)
      end
    end

    describe "when XML source does not contain any relevant data" do
      let(:xml_contents) do
        <<-XML
<?xml version="1.0" encoding="ISO-8859-1"?>
<Root xmlns="http://www.tfl.gov.uk/tims/1.0">
 <Disruptions>
  <Disruption id='143306'>
   <CauseArea>
    <DisplayPoint>
     <Point>
      <coordinatesEN>541443,189139</coordinatesEN>
     </Point>
    </DisplayPoint>
   </CauseArea>
  </Disruption>
 <Disruption id='143081'>
   <CauseArea>
    <DisplayPoint>
     <Point>
      <coordinatesEN>530974,180080</coordinatesEN>
     </Point>
    </DisplayPoint>
   </CauseArea>
  </Disruption>
 <Disruptions>
        XML
      end

      it "should return an empty array " do
        subject.points.must_equal []
      end
    end
  end
end
