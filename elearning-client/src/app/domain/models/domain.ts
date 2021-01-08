export class Domain {
    id: string;
    title: string;
    user: User;
    constructor(){
        this.id = null;
        this.title = "";
        this.user = new User();
    }
}

export class User {
    id: string;
    constructor(){
        this.id = "8d4aff29071ddee43ffa150a3c7aace8"; // NOTE: Daka - Default User
    }
}