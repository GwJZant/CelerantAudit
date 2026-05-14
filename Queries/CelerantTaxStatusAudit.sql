-- Returns all Active products not in ('777 DOG TRAINING CLASSES', '999 PURGE') department
SELECT rpt.BRAND, 
	   rpt.STYLE, 
	   rpt.DESCRIPTION, 
	   rpt.DEPT, 
	   rpt.TYP, 
	   rpt.SUBTYP_1, 
	   rpt.OF1 AS SEASON, 
	   SUM(rpt.QOH) AS [On Hand], 
	   (CASE styles.TAX_CODE_ID
			WHEN 1 THEN 'Non-Taxable'
			ELSE 'Taxable'
		END) AS [Tax Code]
FROM VW_SKU_RPT rpt
INNER JOIN TB_STYLES styles
ON styles.STYLE = rpt.STYLE
AND styles.BRAND = rpt.BRAND
WHERE rpt.DEPT NOT IN ('777 DOG TRAINING CLASSES', '999 PURGE')
AND styles.STATUS_FINISH <> 'Y'
GROUP BY rpt.BRAND, rpt.STYLE, rpt.DESCRIPTION, rpt.DEPT, rpt.TYP, rpt.SUBTYP_1, rpt.OF1, styles.TAX_CODE_ID
--HAVING SUM(rpt.QOH) > 0
ORDER BY rpt.Dept, rpt.Typ, rpt.Subtyp_1, rpt.Style;