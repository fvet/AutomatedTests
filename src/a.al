codeunit 50101 "Container Number"
{
    #region Format
    internal procedure Format(var ContainerNo: code[20])
    var
        Regex: Codeunit Regex;
        StringConversionManagement: Codeunit StringConversionManagement;
        ContainerNoRegexToMatchLbl: Label '^[A-Z]{3}(J|U|Z)\d{7}$', Locked = true;
        StrippedContainerNo: Text;
    begin
        StrippedContainerNo := StringConversionManagement.RemoveNonAlphaNumericCharacters(UpperCase(ContainerNo));

        if Regex.IsMatch(StrippedContainerNo, ContainerNoRegexToMatchLbl) then
            ContainerNo := CopyStr(StrippedContainerNo, 1, 4) + ' ' + CopyStr(StrippedContainerNo, 5, 6) + '/' + CopyStr(StrippedContainerNo, 11);
    end;
    #endregion Format

}