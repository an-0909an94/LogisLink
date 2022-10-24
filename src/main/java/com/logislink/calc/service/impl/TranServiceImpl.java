package com.logislink.calc.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.ui.jasperreports.JasperReportsUtils;

import com.logislink.calc.dao.TranDao;
import com.logislink.calc.service.TranService;
import com.logislink.calc.vo.TranDtlVO;
import com.logislink.calc.vo.TranVO;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfReportConfiguration;
import net.sf.jasperreports.export.SimpleXlsxReportConfiguration;

@Service("tranService")
public class TranServiceImpl implements TranService {
	private Logger log = Logger.getLogger(this.getClass());
	private final String invoice_template_path = "/jasper/Invoice_template.jrxml";
	
	@Resource(name="tranDao")
	private TranDao tranDao;
	
	public void regTranReceipt(Map<String, Object> map) {
		tranDao.regTranReceipt(map);
	}
	
	public List<TranVO> selectTranList(Map<String, Object> map) {
		return tranDao.selectTranList(map);
	}
	
	public int getCnt(Map<String, Object> map) {
		return tranDao.getCnt(map);
	}
	
	public List<TranDtlVO> selectTranDtlList(Map<String, Object> map) {
		return tranDao.selectTranDtlList(map);
	}

	public TranVO selectTranInfo(Map<String, Object> map) {
		return tranDao.selectTranInfo(map);
	}

	@Override
	public void deleteTranReceipt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		tranDao.deleteTranReceipt(map);
	}
	
	@Override
	public File generateInvoiceFor(Map<String, Object> map) throws IOException {
		String root_path = (String) map.get("root_path");
	    String attach_path = "/reportsTemp/";
	    //여기
		File pdfFile = new File(root_path + attach_path + "Invoice_" + System.currentTimeMillis() + ".xlsx");

        log.info(String.format("Invoice pdf path : %s", pdfFile.getAbsolutePath()));

        try(FileOutputStream pos = new FileOutputStream(pdfFile)) {
            final JasperReport report = loadTemplate();

            final Map<String, Object> parameters = parameters((TranVO)map.get("tran"), (Locale)map.get("locale"));

            final JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(Collections.singletonList("Invoice"));

            //JasperReportsUtils.renderAsPdf(report, parameters, dataSource, pos);
            
            JasperPrint jasperPrint = JasperFillManager.fillReport(report, parameters, dataSource);
            
            JRXlsxExporter exporter = new JRXlsxExporter();
            exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
            exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(pdfFile));
            SimpleXlsxReportConfiguration configuration = new SimpleXlsxReportConfiguration();
            configuration.setOnePagePerSheet(true);
            configuration.setDetectCellType(true);
            exporter.setConfiguration(configuration);
            exporter.exportReport();

            //pdfFile.deleteOnExit();
            
            return pdfFile;
        } catch (final Exception e) {
        	log.error(String.format("An error occured during PDF creation: %s", e));
            throw new RuntimeException(e);
        }
	}
	
	@Override
	public File generateInvoice(Map<String, Object> map) throws IOException {
		String rootPath = (String) map.get("root_path");
		String attachPath = "/reportsTemp/";
		TranVO tranData = (TranVO) map.get("tran");
		Locale locale = (Locale) map.get("locale");
		String fileType = (String) map.get("fileType");
		
		File invoiceFile = null;
		
		try {
			if (fileType.equals("e")) {
				invoiceFile = generateInvoiceExcel(rootPath, attachPath, tranData, locale);
			} else {
				invoiceFile = generateInvoicePDF(rootPath, attachPath, tranData, locale);
			}
		} catch(Exception e) {
			log.error(String.format("An error occured during invoice file creation: %s", e));
		}
		
		return invoiceFile;
	}
	
	private JasperReport loadTemplate() throws JRException {

        log.info(String.format("Invoice template path : %s", invoice_template_path));

        final InputStream reportInputStream = getClass().getResourceAsStream(invoice_template_path);
        final JasperDesign jasperDesign = JRXmlLoader.load(reportInputStream);

        return JasperCompileManager.compileReport(jasperDesign);
    }
	
	//jasper 레포트에 파라미터 세팅
	private Map<String, Object> parameters(TranVO tran, Locale locale) {
        final Map<String, Object> parameters = new HashMap<>();
        
        ResourceBundle bundle = ResourceBundle.getBundle("/jasper/localization/InvoiceResourceBundle_ko_KR",Locale.KOREAN);
        parameters.put("tran",  tran);
        //parameters.put("REPORT_LOCALE", Locale.KOREAN);
        //parameters.put("REPORT_LOCALE", LocaleManager.currentLocale());
        parameters.put("REPORT_RESOURCE_BUNDLE", bundle);

        return parameters;
    }

	@Override
	public void regTranReceiptForDriver(Map<String, Object> map) {
		tranDao.regTranReceiptForDriver(map);
	}
	
	// Excel로 거래명세서 출력
	private File generateInvoiceExcel(String rootPath, String attachPath, TranVO tranData, Locale locale) throws Exception {
		File invoiceFile = new File(rootPath + attachPath + "Invoice_" + System.currentTimeMillis() + ".xlsx");
		log.info(String.format("Invoice file path : %s", invoiceFile.getAbsolutePath()));
		
		// 파일 생성
		FileOutputStream pos = new FileOutputStream(invoiceFile);
		final JasperReport report = loadTemplate();
		final Map<String, Object> parameters = parameters(tranData, locale);
		final JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(Collections.singletonList("Invoice"));

		JasperPrint jasperPrint = JasperFillManager.fillReport(report, parameters, dataSource);
		
		JRXlsxExporter exporter = new JRXlsxExporter();
		exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(invoiceFile));
		SimpleXlsxReportConfiguration configuration = new SimpleXlsxReportConfiguration();
		configuration.setOnePagePerSheet(true);
		configuration.setDetectCellType(true);
		exporter.setConfiguration(configuration);
		exporter.exportReport();
		
		return invoiceFile;
	}
	
	// PDF로 거래명세서 출력
	private File generateInvoicePDF(String rootPath, String attachPath, TranVO tranData, Locale locale) throws Exception {
		File invoiceFile = new File(rootPath + attachPath + "Invoice_" + System.currentTimeMillis() + ".pdf");
		log.info(String.format("Invoice file path : %s", invoiceFile.getAbsolutePath()));
		
		// 파일 생성
		FileOutputStream pos = new FileOutputStream(invoiceFile);
		final JasperReport report = loadTemplate();
		final Map<String, Object> parameters = parameters(tranData, locale);
		final JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(Collections.singletonList("Invoice"));

		JasperPrint jasperPrint = JasperFillManager.fillReport(report, parameters, dataSource);
		
		JRPdfExporter exporter = new JRPdfExporter();
		exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(invoiceFile));
		SimplePdfReportConfiguration configuration = new SimplePdfReportConfiguration();
		exporter.setConfiguration(configuration);
		exporter.exportReport();
		
		return invoiceFile;
	}
}
