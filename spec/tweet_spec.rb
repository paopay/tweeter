require 'spec_helper'

describe Tweet do
  it 'should create a Tweet' do
    tweet = Tweet.create({
      content:  "hihi",
      location: "here"
    })
    expect(tweet.id).to eq(Tweet.last.id)
  end

  it 'should not create when tweet is nil' do
    tweet = Tweet.create({
      content:  "",
      location: "here"
    })
    expect(tweet.id).to eq(nil)
  end

  it 'should not create when tweet is more than 140 chars' do
    tweet = Tweet.create({
      content:  "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901",
      location: "here"
    })
    expect(tweet.id).to eq(nil)
  end

  it 'should create when tweet has no location' do
    tweet = Tweet.create({
      content:  "test",
      location: ""
    })
    expect(tweet.id).to eq(Tweet.last.id)
  end
end
