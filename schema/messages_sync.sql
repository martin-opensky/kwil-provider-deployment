database messages_sync_eg;

use db_sync{
  original_dbid: 'x3f2c4402383b358218eb01e7c9030475ec276ee0782f891e79edde86',
  local_db_name: 'messages_sync_eg'
} as db_sync;

use helpers as helper;

table messages {
  id text maxlen(21) primary notnull,
  message text notnull maxlen(100),
  wallet text notnull,
  created_at text notnull,
  #wallet_index index(wallet)
}

table db_sync_history {
    id text maxlen(21) primary notnull,
    action_timestamp int notnull,
    arweave_id text notnull,
    provider_address text notnull,
    executed_at text notnull
}

action insert_message ($message) public {
  $id = helper.id();
  $date = helper.date();

  INSERT INTO messages
  VALUES ($id, $message, @caller, $date);

  $sync = db_sync.save_action('insert_message_sync', $id, $message, @caller, $date);

  SELECT $sync as id;
}

action insert_message_sync ($id, $message, $original_caller, $date) private {
  INSERT INTO messages
  VALUES ($id, $message, $original_caller, $date);
}

action save_db_sync($id, $action_timestamp, $arweave_id, $provider_address, $executed_at) private {
  INSERT INTO db_sync_history VALUES ($id, $action_timestamp, $arweave_id, $provider_address, $executed_at);
}
