shared_examples_for 'falsy and error setter' do |message|
  it 'returns false and sets error message' do
    expect(subject.destroy).to equal(false)
    expect(subject.errors[:delete]).to include message
  end
end