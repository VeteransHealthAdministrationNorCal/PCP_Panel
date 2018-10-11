SELECT
  s1.StaffName
  ,s1.SignatureBlockTitle
  ,patient.PatientName
  ,patient.PatientSSN
FROM
  CDWWork.RPCMM.CurrentPatientProviderRelationship AS CPPR
  INNER JOIN CDWWork.NDim.RPCMMTeamRole AS r1
    ON CPPR.PrimaryProviderTeamRoleSID = r1.RPCMMTeamRoleSID
  INNER JOIN CDWWork.SStaff.SStaff AS s1
    ON CPPR.PrimaryProviderSID = s1.StaffSID
  INNER JOIN CDWWork.SPatient.Spatient AS patient
    ON patient.PatientSID = CPPR.PatientSID
WHERE
  CPPR.sta3n = '612'
  AND CPPR.RPCMMTeamCareType LIKE 'PRIMARY CARE%'
  AND patient.PatientName NOT LIKE 'zz%'
  AND (
    r1.PrimaryCarePositionIndicator = 'Y'
    OR r1.TeamRoleCode = '4'  
    OR r1.TeamRoleCode = '25' 
  )
GROUP BY
  s1.StaffName
  ,patient.PatientName
  ,patient.PatientSSN
  ,s1.SignatureBlockTitle
ORDER BY
  s1.StaffName
  ,patient.PatientName
  ,patient.PatientSSN
