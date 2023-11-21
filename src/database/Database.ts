import config from "../config/config";
import { connect } from "mongoose";
class Database {
	static connect = async () => {
		await connect(`${config.databaseUrl}`)
			.then(() => {
				console.log("database connected");
			})
			.catch((error) => {
				console.log(`Database connection error: ${error}`);
			});
	};
}

export default Database;
