codeunit 50100 "Container Tests"
{
    // [FEATURE] Container
    Subtype = Test;

    #region TestContainerNoWithValidFormat
    [Test]
    procedure TestContainerNoWithValidFormat()
    var
        ContainerNo: Code[20];
    begin
        // [SCENARIO] A container number with valid format 'AAAA 999999/9' should be valid
        Initialize();

        // [GIVEN] A container number with valid format       
        ContainerNo := 'CMAU 123456/7';

        // [WHEN] When formatting the container no.         
        ContainerNumber.Format(ContainerNo);

        // [THEN] The number should apply the standard format
        Assert.AreEqual('CMAU 123456/7', ContainerNo, 'Container no. format');

    end;
    #endregion TestContainerNoWithValidFormat    

    #region TestFormatContainerNoWithoutSpacesMustApplyStandardFormat
    [Test]
    procedure TestFormatContainerNoWithoutSpacesMustApplyStandardFormat()
    var
        ContainerNo: Code[20];
    begin
        // [SCENARIO] A valid container number without spaces 'AAAA999999/9' should apply the standard format 'AAAA 999999/9'
        Initialize();

        // [GIVEN] A valid container number without spaces   
        ContainerNo := 'CMAU123456/7';

        // [WHEN] When formatting the container no.         
        ContainerNumber.Format(ContainerNo);

        // [THEN] The number should apply the standard format
        Assert.AreEqual('CMAU 123456/7', ContainerNo, 'Container no. format');
    end;
    #endregion TestFormatContainerNoWithoutSpacesMustApplyStandardFormat

    #region Initialize
    local procedure Initialize()
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"Container Tests");

        ClearLastError();
        LibraryVariableStorage.Clear();
        LibrarySetupStorage.Restore();
        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"Container Tests");

        LibraryRandom.Init();

        // Prepare setup tables etc. that are used for all test functions

        IsInitialized := true;
        Commit();

        // Add all setup tables that are changed by tests to the SetupStorage, so they can be restored for each test function that calls Initialize.
        // This is done InMemory, so it could be run after the COMMIT above
        // LibrarySetupStorage.Save(Database::"[SETUP TABLE ID]");

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"Container Tests");
    end;
    #endregion Initialize

    var
        Assert: Codeunit Assert;
        LibraryRandom: Codeunit "Library - Random";
        LibrarySetupStorage: Codeunit "Library - Setup Storage";
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        IsInitialized: Boolean;
        ContainerNumber: Codeunit "Container Number";
}