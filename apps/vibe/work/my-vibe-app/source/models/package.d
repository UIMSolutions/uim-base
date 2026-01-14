module models;

export struct Document {
    string title;
    string content;
    DateTime createdAt;
    DateTime updatedAt;

    void updateContent(string newContent) {
        content = newContent;
        updatedAt = DateTime.now();
    }
}

export struct User {
    string username;
    string email;
    string passwordHash;

    bool validatePassword(string password) {
        // Implement password validation logic here
        return passwordHash == hashPassword(password);
    }

    private string hashPassword(string password) {
        // Implement hashing logic here
        return password; // Placeholder
    }
}