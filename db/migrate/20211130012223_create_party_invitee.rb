class CreatePartyInvitee < ActiveRecord::Migration[5.2]
  def change
    create_table :party_invitees do |t|
      t.references :user, foreign_key: true
      t.references :party, foreign_key: true

      t.timestamps
    end
  end
end
