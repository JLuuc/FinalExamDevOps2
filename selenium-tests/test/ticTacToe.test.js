const { Builder, By } = require('selenium-webdriver');
const chrome = require('selenium-webdriver/chrome');
const assert = require('assert');
const fs = require('fs');
const os = require('os');
const path = require('path');

async function testPlayerMoveDisplaysSymbol() {
  const tmpDir = fs.mkdtempSync(path.join(os.tmpdir(), 'chrome-profile-'));

  const options = new chrome.Options();
  options.addArguments('--headless');
  options.addArguments('--no-sandbox');
  options.addArguments('--disable-dev-shm-usage');
  options.addArguments(`--user-data-dir=${tmpDir}`);

  const driver = await new Builder()
    .forBrowser('chrome')
    .setChromeOptions(options)
    .build();

  try {
    await driver.get('http://52.90.207.30');

    const cell = await driver.findElement(By.id('cell0'));
    await cell.click();

    const cellHtml = await cell.getAttribute('innerHTML');
    assert(cellHtml.includes('x') || cellHtml.includes('o'), 'Expected X or O not found!');
    console.log('✅ Test passed!');
  } catch (error) {
    console.error('❌ Test failed:', error);
  } finally {
    await driver.quit();
    fs.rmSync(tmpDir, { recursive: true, force: true }); // Clean up
  }
}

testPlayerMoveDisplaysSymbol();

