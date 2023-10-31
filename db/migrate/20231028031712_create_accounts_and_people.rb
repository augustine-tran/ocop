# frozen_string_literal: true

class CreateAccountsAndPeople < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :identities do |t|
      t.string :name,           null: false
      t.string :email,           null: false, index: { unique: true }
      t.string :password_digest, null: false

      t.boolean :verified, null: false, default: false

      t.timestamps
    end

    create_table :users do |t|
      t.references :identity, null: false, foreign_key: true
      t.timestamps
    end

    create_table :clients do |t|
      t.references :identity, null: false, foreign_key: true
      t.timestamps
    end

    create_table :tombstones do |t|
      t.references :user, foreign_key: true
      t.references :client, foreign_key: true
      t.json :details, default: {}
      t.timestamps
    end

    create_table :people do |t|
      t.references :account, null: false, foreign_key: true
      t.references :personable, polymorphic: true, null: false
      t.timestamps
    end

    create_table :administratorships do |t|
      t.references :account, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true
      t.timestamps
    end

    create_table :ownerships do |t|
      t.references :account, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true
      t.timestamps
    end
  end
end
