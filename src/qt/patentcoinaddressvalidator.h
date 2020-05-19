// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef PATENTCOIN_QT_PATENTCOINADDRESSVALIDATOR_H
#define PATENTCOIN_QT_PATENTCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class PatentcoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit PatentcoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

/** Patentcoin address widget validator, checks for a valid patentcoin address.
 */
class PatentcoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit PatentcoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

#endif // PATENTCOIN_QT_PATENTCOINADDRESSVALIDATOR_H
