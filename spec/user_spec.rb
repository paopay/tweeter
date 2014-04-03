require 'spec_helper'

describe User do
  context 'when not logged in' do
    it 'should create a new user' do
      user = User.create({
        name:     "test",
        email:    "test@test.com",
        password: "test",
        handle:   "test"
      })
      expect(user.name).to eq("test")
    end

    it 'should not create with invalid email' do
      user = User.create({
        name:     "test",
        email:    "testasdfgadghsfgj",
        password: "test",
        handle:   "test"
      })
      expect(user.id).to eq(nil)
    end

    it 'should not create when email is not unique' do
      user1 = User.create({
        name:     "test1",
        email:    "test@test.com",
        password: "test",
        handle:   "test1"
      })

      user2 = User.create({
        name:     "test2",
        email:    "test@test.com",
        password: "test",
        handle:   "test2"
      })

      expect(user2.id).to eq(nil)
    end

    it 'should not create when handle is not unique' do
      user1 = User.create({
        name:     "test1",
        email:    "test1@test.com",
        password: "test",
        handle:   "test"
      })

      user2 = User.create({
        name:     "test2",
        email:    "test2@test.com",
        password: "test",
        handle:   "test"
      })
      expect(user2.id).to eq(nil)
    end

    it 'should not create when password is nil' do
      user = User.create({
        name:     "test1",
        email:    "test1@test.com",
        password: "",
        handle:   "test"
      })
      expect(user.id).to eq(nil)
    end
  end
end
