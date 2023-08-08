database messages_backup;

use db_export as db_export;
use helpers as helper;

table messages {
  id text maxlen(21) primary notnull,
  message text notnull maxlen(100),
  wallet text notnull,
  created_at text notnull,
  #wallet_index index(wallet)
}

action insert_message ($message) public {
  $id = helper.id();
  $date = helper.date();

  INSERT INTO messages
  VALUES ($id, $message, @caller, $date);
}

action start_export () private {
  $id = db_export.start(@dataset);

  SELECT $id as id;
}
