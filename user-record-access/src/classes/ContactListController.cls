public with sharing class ContactListController {
	public List<Contact> contacts { get; private set; }

	public ContactListController() {
		this.contacts = this.getEditableContacts();
	}

	public List<Contact> getEditableContacts() {
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
}
