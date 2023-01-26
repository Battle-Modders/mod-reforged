var ReforgedJSConnection = function(_parent)
{
    MSUBackendConnection.call(this);
    this.mModID = Reforged.ID;
    this.mID = Reforged.JSConnectionID;
}

ReforgedJSConnection.prototype = Object.create(MSUBackendConnection.prototype);
Object.defineProperty(ReforgedJSConnection.prototype, 'constructor', {
    value: ReforgedJSConnection,
    enumerable: false,
    writable: true
});

registerScreen(Reforged.JSConnectionID, new ReforgedJSConnection());
