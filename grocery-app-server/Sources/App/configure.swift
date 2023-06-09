import Vapor
import JWT
import Fluent 
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // configure database
    app.databases.use(.postgres(hostname: "localhost", username: "postgres", password: "", database: "grocerydb"), as: .psql)
    
    //try app.databases.use(.postgres(url: "postgres://hdrqiidw:JrwDDiet31AjKpDOvtFTjKi4ynX_2MBI@localhost/grocery-"), as: .psql)
    
    // register migrations
    app.migrations.add(CreateUsersTableMigration())
    app.migrations.add(CreateGroceryCategoriesTableMigration())
    app.migrations.add(CreateGroceryItemTableMigration())
    
    // register the controllers
    try app.register(collection: UserController())
    try app.register(collection: GroceryController())
    
    app.jwt.signers.use(.hs256(key: "secret"))
    
    // register routes
    try routes(app)
}
