public with sharing class ContactListController {
	public List<Contact> contacts { get; private set; }

	public ContactListController() {
		this.contacts = this.getEditableContacts();
	}

	public List<Contact> getEditableContactsOld() {
		Map<Id, Contact> contactMap = new Map<Id, Contact>([
			SELECT Id, Name, Email FROM Contact
		]);

		List<UserRecordAccess> accesses = [
			SELECT
				RecordId, HasEditAccess
			FROM
				UserRecordAccess
			WHERE
				UserId = :UserInfo.getUserId()
			AND
				RecordId IN :contactMap.keySet()
		];

		List<Contact> result = new List<Contact>();
		for (UserRecordAccess access : accesses) {
			if (access.HasEditAccess) {
				result.add(contactMap.get(access.RecordId));
			}
		}
		return result;
	}

	/** Since API version 30.0 **/
	public List<Contact> getEditableContacts() {
		List<Contact> contacts = [
			SELECT
				Id, Name, Email,
				UserRecordAccess.HasEditAccess
			FROM
				Contact
		];
		List<Contact> result = new List<Contact>();
		for (Contact contact : contacts) {
			System.debug('Contact [' + contact.Name + '] is editable?: ' + contact.UserRecordAccess.HasEditAccess);
			if (contact.UserRecordAccess.HasEditAccess) {
				result.add(contact);
			}
		}
		return result;
	}
}
